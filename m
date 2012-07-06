From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Fri, 06 Jul 2012 09:03:16 +0800
Message-ID: <4FF63954.5040408@redhat.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<1340002390-3950-4-git-send-email-asias@redhat.com>
	<87hau9yse7.fsf@rustcorp.com.au> <4FDEE0CB.1030505@redhat.com>
	<87zk81x7dp.fsf@rustcorp.com.au> <4FDF0DA7.40604@redhat.com>
	<1340019575.22848.2.camel@lappy> <4FDFE926.7030309@redhat.com>
	<87r4svxcjw.fsf@rustcorp.com.au> <4FF10B31.60609@redhat.com>
	<8762a6y89v.fsf@rustcorp.com.au> <4FF23F4B.2040803@redhat.com>
	<87lij0w8np.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87lij0w8np.fsf@rustcorp.com.au>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Sasha Levin <levinsasha928@gmail.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On 07/04/2012 10:40 AM, Rusty Russell wrote:
> On Tue, 03 Jul 2012 08:39:39 +0800, Asias He <asias@redhat.com> wrote:
>> On 07/02/2012 02:41 PM, Rusty Russell wrote:
>>> Sure, our guest merging might save us 100x as many exits as no merging.
>>> But since we're not doing many requests, does it matter?
>>
>> We can still have many requests with slow devices. The number of
>> requests depends on the workload in guest. E.g. 512 IO threads in guest
>> keeping doing IO.
>
> You can have many requests outstanding.  But if the device is slow, the
> rate of requests being serviced must be low.

Yes.

> Am I misunderstanding something?  I thought if you could have a high
> rate of requests, it's not a slow device.

Sure.

-- 
Asias
