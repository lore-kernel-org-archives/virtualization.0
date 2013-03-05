From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH] tcm_vhost: Add hotplug/hotunplug support
Date: Tue, 05 Mar 2013 14:51:52 -0800
Message-ID: <1362523912.7905.208.camel__31926.419263664$1362523949$gmane$org@haakon2.linux-iscsi.org>
References: <1362475027-12018-1-git-send-email-asias@redhat.com>
	<20130305121125.GA823@redhat.com> <5135F150.1060206@redhat.com>
	<20130305143416.GG2256@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130305143416.GG2256@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2013-03-05 at 16:34 +0200, Michael S. Tsirkin wrote:
> On Tue, Mar 05, 2013 at 02:21:20PM +0100, Paolo Bonzini wrote:
> > Il 05/03/2013 13:11, Michael S. Tsirkin ha scritto:
> > >> > +
> > >> > +	struct vhost_work vs_event_work; /* evt injection work item */
> > >> > +	struct llist_head vs_event_list; /* evt injection queue */
> > >> > +
> > >> > +	bool vs_events_dropped;
> > > Documentation pls.
> > > Also - how is this handled during migration?
> > 
> > Migration is not supported by vhost-scsi but yes, we would need to
> > retrieve this bit.
> > 
> > Paolo
> 
> Well at the moment nothing is supported as there's no userspace
> upstream :(
> 
> > > Don't we need a way for userspace to retrieve this bit?
> > > 

Btw, the vhost-scsi userspace with ABIv1 bumped for Asias's v3.9
tcm_vhost multi-target kernel changes are here:

http://git.kernel.org/cgit/virt/kvm/nab/qemu-kvm.git/log/?h=vhost-scsi-for-1.3-abi-v1

For making progress with Paolo's vhost-scsi branch on my side, this was
still being blocked by bios boot hangs:

http://www.spinics.net/lists/target-devel/msg03830.html

Paolo & Co, any ideas on the latter..?

--nab
