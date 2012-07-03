From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Tue, 03 Jul 2012 22:02:05 +0800
Message-ID: <4FF2FB5D.5030102@redhat.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<1340002390-3950-4-git-send-email-asias@redhat.com>
	<87hau9yse7.fsf@rustcorp.com.au> <4FDEE0CB.1030505@redhat.com>
	<87zk81x7dp.fsf@rustcorp.com.au> <4FDF0DA7.40604@redhat.com>
	<1340019575.22848.2.camel@lappy> <4FDFE926.7030309@redhat.com>
	<87r4svxcjw.fsf@rustcorp.com.au> <4FF10B31.60609@redhat.com>
	<8762a6y89v.fsf@rustcorp.com.au> <4FF2F417.2010209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FF2F417.2010209@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Sasha Levin <levinsasha928@gmail.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On 07/03/2012 09:31 PM, Paolo Bonzini wrote:
> Il 02/07/2012 08:41, Rusty Russell ha scritto:
>>> With the same workload in guest, the guest fires 200K requests to host
>>> with merges enabled in guest (echo 0 > /sys/block/vdb/queue/nomerges),
>>> while the guest fires 40000K requests to host with merges disabled in
>>> guest (echo 2 > /sys/block/vdb/queue/nomerges). This show that the merge
>>> in block layer reduces the total number of requests fire to host a lot
>>> (40000K / 200K = 20).
>>>
>
> 40000 / 200 is 200, not 20. :)

Crap, I wrote one more zero here. Actually, it is 4000K. So the factor 
is still 4000K/200k = 20 ;-)

-- 
Asias
