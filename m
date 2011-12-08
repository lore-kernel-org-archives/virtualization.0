From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v4 00/12] virtio: s4 support
Date: Thu, 8 Dec 2011 17:26:40 +0530
Message-ID: <20111208115640.GE23531@amit-x200.redhat.com>
References: <cover.1323199985.git.amit.shah@redhat.com>
	<87wra8j13m.fsf@rustcorp.com.au>
	<20111207074456.GD4651@amit-x200.redhat.com>
	<87liqoirgm.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87liqoirgm.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, levinsasha928@gmail.com, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 07 Dec 2011 [21:22:41], Rusty Russell wrote:
> On Wed, 7 Dec 2011 13:14:56 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> > On (Wed) 07 Dec 2011 [17:54:29], Rusty Russell wrote:
> > > I figure there's a reason, but it seems a bit weird :)
> > 
> > Well, there is one reason right now: migrating storage along with
> > VMs.  The guest needs to sync all data to the disk before the target
> > host accesses the image file.
> 
> I don't see why.  Sure, if qemu (or whatever) is doing buffering, it
> needs to flush that.  It doesn't, last I looked, it just maps to
> read/write.
> 
> What am I missing?

I'm sorry, I got confused.  The external file migration Gleb
mentioned, though, is something that libvirt uses right now and causes
guest time craziness so S4 is one (and natural) way to solve it.

		Amit
