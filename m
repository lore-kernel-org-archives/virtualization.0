From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH] blkfront: don't change to closing if
	we're busy
Date: Tue, 21 Feb 2012 09:14:13 +0000
Message-ID: <4F436E75020000780007409F@nat28.tlf.novell.com>
References: <20120217185836.GA23942@phenom.dumpdata.com>
	<2f885124-dcd7-42c0-ade3-e164457513fe@zmail17.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2f885124-dcd7-42c0-ade3-e164457513fe@zmail17.collab.prod.int.phx2.redhat.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Jones <drjones@redhat.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>>> On 20.02.12 at 11:35, Andrew Jones <drjones@redhat.com> wrote:

> 
> ----- Original Message -----
>> On Fri, Feb 17, 2012 at 05:52:54PM +0100, Andrew Jones wrote:
>> > On Thu, Feb 16, 2012 at 12:33:32PM -0500, Andrew Jones wrote:
>> > > Hmm, I should maybe self-nack this. The bug that led me to
>> > > writing
>> > > it is likely only with older tooling, such as RHEL5's. The
>> > > problem
>> > > was if you attempted to detach a mounted disk twice, then the
>> > > second
>> > > time it would succeed. The guest had flipped to Closing on the
>> > > first
>> > > try, and thus didn't issue an error to xenbus on the second. I
>> > > see
>> > 
>> > Actually, it's even worse than I thought. Just a single attempt to
>> > detach the device will cause the guest grief (with RHEL5's tools
>> > anyway). Once xenbus shows the device is in the Closing state, then
>> > tasks accessing the device may hang.
>> > 
>> > > The reason I only say maybe self-nack though, is because this
>> > > state
>> > > change seemed to be thrown in with another fix[1]. I'm not sure
>> > > if
>> > > the new behavior on legacy hosts was considered or not. If not,
>> > > then
>> > > we can consider it now. Do we want to have deferred asynch
>> > > detaches
>> > > over protecting the guest from multiple detach calls on legacy
>> > > hosts?
>> > > 
>> > 
>> > I guess we can keep the feature and protect the guest with a patch
>> > like
>> > I'll send in a moment. It doesn't really work for me with a RHEL5
>> > host
>> > though. The deferred close works from the pov of the guest, but the
>> > state of the block device gets left in Closed after the guest
>> > unmounts
>> > it, and then RHEL5's tools can't detach/reattach it. If the
>> > deferred
>> > close ever worked on other Xen hosts though, then I don't believe
>> > this
>> > patch would break it, and it will also keep the guest safe when run
>> > on
>> > hosts that don't treat state=Closing the way it currently expects.
>> 
>> There was another fix that sounds similar to this in the backend.
>> 6f5986bce558e64fe867bff600a2127a3cb0c006
>> 
> 
> Thanks for the pointer. It doesn't look like the upstream 2.6.18
> tree has that, but it probably would be a good idea there too.

While I had seen the change and considered pulling it in, I wasn't
really convinced this is the right behavior here: After all, if the host
admin requested a resource to be removed from a guest, it shouldn't
depend on the guest whether and when to honor that request, yet
by deferring the disconnect you basically allow the guest to continue
using the disk indefinitely.

Jan

> However, even with that ability to patch backends, we probably
> want the frontends to be more robust on legacy backends for a while
> longer. So, it probably would be best to avoid changing the state to
> Closing while we're still busy, unless it's absolutely necessary.
> 
> Drew
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com 
> http://lists.xensource.com/xen-devel 
