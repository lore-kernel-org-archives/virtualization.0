From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-blk: make the queue depth the max supportable by
	the hypervisor
Date: Wed, 02 Apr 2014 18:06:08 +1030
Message-ID: <878urop4if.fsf@rustcorp.com.au>
References: <1394841445-16142-1-git-send-email-venkateshs@google.com>
	<1394854471-25700-1-git-send-email-tytso@mit.edu>
	<87siqhu048.fsf@rustcorp.com.au> <20140317054053.GF14162@thunk.org>
	<871txysnw2.fsf@rustcorp.com.au>
	<CAHdzE-_cAndCNhBM1N0RpjQDhoh3Snas-eza4rYN33Rf69PXyw@mail.gmail.com>
	<CAHdzE--CvgsPOFQ5OFRoe7L+kkJ0J3eRWR0JQv34i4AmNDBJug@mail.gmail.com>
	<87ha6fowh9.fsf@rustcorp.com.au> <20140401022708.GD4911@thunk.org>
	<CAJSP0QV_mf9D0t5ozWRRsMO1Wq7OTQ8SiOKh-HrW7buzNQQngQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QV_mf9D0t5ozWRRsMO1Wq7OTQ8SiOKh-HrW7buzNQQngQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>, Theodore Ts'o <tytso@mit.edu>, Venkatesh Srinivas <venkateshs@google.com>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Stefan Hajnoczi <stefanha@gmail.com> writes:
> On Tue, Apr 1, 2014 at 4:27 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>> On Mon, Mar 31, 2014 at 02:22:50PM +1030, Rusty Russell wrote:
>>>
>>> It's head of my virtio-next tree.
>>
>> Hey Rusty,
>>
>> While we have your attention --- what's your opinion about adding TRIM
>> support to virtio-blk.  I understand that you're starting an OASIS
>> standardization process for virtio --- what does that mean vis-a-vis a
>> patch to plumb discard support through virtio-blk?
>
> virtio-scsi already supports discard.  But maybe you cannot switch
> away from virtio-blk?
>
> If you need to add discard to virtio-blk then it could be added to the
> standard.  The standards text is kept in a svn repository here:
> https://tools.oasis-open.org/version-control/browse/wsvn/virtio/

It would be trivial to add, and I wouldn't be completely opposed, but we
generally point to virtio-scsi when people want actual features.

Cheers,
Rusty.
