From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/4] tcm_vhost: Fix vs->vs_endpoint checking in
	vhost_scsi_handle_vq()
Date: Wed, 13 Mar 2013 09:02:38 +0100
Message-ID: <5140329E.6090408@redhat.com>
References: <1363056171-5854-1-git-send-email-asias@redhat.com>
	<1363056171-5854-4-git-send-email-asias@redhat.com>
	<20130312111119.GA6788@redhat.com>
	<20130313031303.GD15369@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130313031303.GD15369@hj.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 13/03/2013 04:13, Asias He ha scritto:
>> > This takes dev mutex on data path which will introduce
>> > contention esp for multiqueue.
> Yes, for now it is okay, but for concurrent execution of multiqueue it is
> really bad.
> 
> By the way, what is the overhead of taking and releasing the
> vs->dev.mutex even if no one contents for it? Is this overhead gnorable.

There is a possibility of cacheline ping-pong, but apart from that it's
ignorable.

>> > How about storing the endpoint as part of vq
>> > private data and protecting with vq mutex?
> 
> Hmm, this makes sense, let's see how well it works.

Then VHOST_SCSI_SET_ENDPOINT would have to go through all vqs, no?  A
rwlock seems simpler.

Paolo
