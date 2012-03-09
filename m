From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH] blkfront: don't change to closing if
	we're busy
Date: Fri, 09 Mar 2012 13:32:40 +0000
Message-ID: <4F5A148802000078000775A3@nat28.tlf.novell.com>
References: <4F436E75020000780007409F@nat28.tlf.novell.com>
	<0321d9ab-a725-47af-b6f6-8342aa1d7c5f@zmail17.collab.prod.int.phx2.redhat.com>
	<4F43743102000078000740C2@nat28.tlf.novell.com>
	<20120221143634.GD5652@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120221143634.GD5652@phenom.dumpdata.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: joe.jin@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: jeremy@goop.org, xen-devel <xen-devel@lists.xen.org>, Andrew Jones <drjones@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>>> On 21.02.12 at 15:36, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> On Tue, Feb 21, 2012 at 09:38:41AM +0000, Jan Beulich wrote:
>> >>> On 21.02.12 at 10:23, Andrew Jones <drjones@redhat.com> wrote:
>> >> >>> On 20.02.12 at 11:35, Andrew Jones <drjones@redhat.com> wrote:
>> >> >> On Fri, Feb 17, 2012 at 05:52:54PM +0100, Andrew Jones wrote:
>> >> >> There was another fix that sounds similar to this in the backend.
>> >> >> 6f5986bce558e64fe867bff600a2127a3cb0c006
>> >> >> 
>> >> > 
>> >> > Thanks for the pointer. It doesn't look like the upstream 2.6.18
>> >> > tree has that, but it probably would be a good idea there too.
>> >> 
>> >> While I had seen the change and considered pulling it in, I wasn't
>> >> really convinced this is the right behavior here: After all, if the
>> >> host
>> >> admin requested a resource to be removed from a guest, it shouldn't
>> >> depend on the guest whether and when to honor that request, yet
>> >> by deferring the disconnect you basically allow the guest to continue
>> >> using the disk indefinitely.
>> >> 
>> > 
>> > I agree. Yesterday I wrote[1] asking if "deferred detach" is really
>> > something we want. At the moment, Igor and I are poking through
>> > xen-blkfront.c, and currently we'd rather see the feature dropped
>> > in favor of a simplified driver. One that has less release paths,
>> > and/or release paths with more consistent locking behavior.
>> 
>> I must have missed this, or it's one more instance of delayed mail
>> delivery via xen-devel.
>> 
>> Konrad - care to revert that original change as having barked up
>> the wrong tree?
> 
> Meaning the 6f5986bce558e64fe867bff600a2127a3cb0c006?
> 
> Lets CC Joe Jin here to get his input. I recall that the --force argument
> still works with that patch so the admin can still choose to terminate the
> state. Which I thought was the point of the --force - as in if the
> guest is still using it, we won't be yanking it out until we are
> completly sure.

Actually I meanwhile think that rather than fully reverting the
change, xen_blkif_disconnect() should be called in both the
XenbusStateClosing and XenbusStateClosed cases, not the least
since the frontend only ever sets the state to Closing when there
are still active users. Not doing the disconnect can e.g. result in
grant reference (and page) leaks e.g. when the frontend driver
gets unloaded while there are still existing (but obviously unused)
devices, and those can't even be eliminated by adding leak
handling code to gnttab_end_foreign_access() (the freeing then
gets deferred until a frontend driver gets loaded again and re-
attaches to the device - currently impossible in the upstream
driver as xlblk_exit() fails to call unregister_blkdev(); see
http://xenbits.xen.org/hg/linux-2.6.18-xen.hg/rev/99dc6737898b).

Jan
