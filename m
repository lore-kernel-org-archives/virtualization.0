From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V2 0/6] tcm_vhost hotplug/hotunplug support and
	locking/flushing fix
Date: Wed, 13 Mar 2013 09:11:32 +0100
Message-ID: <514034B4.5060100@redhat.com>
References: <1362709307-12554-1-git-send-email-asias@redhat.com>
	<20130311120327.GE23359@redhat.com>
	<20130312023109.GF1480@hj.localdomain>
	<20130312095514.GC22633@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130312095514.GC22633@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 12/03/2013 10:55, Michael S. Tsirkin ha scritto:
> > Why? Why should qemu prevent from improving the driver and the benefit
> > to the other user of the driver? Kvm tool is already using it since last
> > Aug. This adds the missing disk hotplug support to kvm tool.
> 
> Basically we shouldn't add stuff to kernel for a single user.
> Before we commit to support features forever, let's take the time
> to see that the interfaces satisfy the requirements of multiple users.

The userspace components of vhost-scsi do not need any new kernel API to
get this new feature.  In fact, there is no new kernel API introduced by
the hotplug/hotunplug patches.

> > Plus, this is not a pure "feature", it is designed in virtio-scsi spec. 
> 
> The spec doesn't say it's a mandatory feature or did I miss something?

It's not mandatory to support hotplug.  However, it is mandatory for the
device to provide an event virtqueue, even if it will never report an
event and it will do nothing with the virtqueue.  For this reason, a
compliant userspace must already have all the support for this.

Paolo
