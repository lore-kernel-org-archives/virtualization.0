From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/2] virtio-ring: Allocate indirect buffers from cache
	when possible
Date: Mon, 10 Sep 2012 17:52:41 +0200
Message-ID: <504E0CC9.1040905@redhat.com>
References: <1346159043-16446-1-git-send-email-levinsasha928@gmail.com>
	<1346159043-16446-2-git-send-email-levinsasha928@gmail.com>
	<20120828132032.GB2039@redhat.com> <503CC904.3050207@gmail.com>
	<20120829110748.GB5970@redhat.com> <503E2F27.5060904@gmail.com>
	<20120829153833.GE7407@redhat.com> <503E4873.6060607@gmail.com>
	<871uigj747.fsf@rustcorp.com.au>
	<20120906050257.GA17656@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120906050257.GA17656@redhat.com>
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
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Sasha Levin <levinsasha928@gmail.com>, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Il 06/09/2012 07:02, Michael S. Tsirkin ha scritto:
>> > It might be worth just unconditionally having a cache for the 2
>> > descriptor case.  This is what I get with qemu tap, though for some
>> > reason the device features don't have guest or host CSUM, so my setup is
>> > probably screwed:
> Yes without checksum net core always linearizes packets, so yes it is
> screwed.
> For -net, skb always allocates space for 17 frags + linear part so
> it seems sane to do same in virtio core, and allocate, for -net,
> up to max_frags + 1 from cache.
> We can adjust it: no _SG -> 2 otherwise 18.
> 
> Not sure about other drivers, maybe really use 2 there for now.

2 should also be good for virtio-blk and virtio-scsi 4KB random rw
workloads.

Paolo
