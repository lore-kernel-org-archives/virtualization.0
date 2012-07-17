From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/5] Add vhost-blk support
Date: Tue, 17 Jul 2012 11:32:45 +0200
Message-ID: <5005313D.1000300__46232.39267753$1342517582$gmane$org@redhat.com>
References: <1342107302-28116-1-git-send-email-asias@redhat.com>
	<CAJSP0QWgmXns89se+xdGgM6i1_hsfVWPQ8caHua9d-dDA4CTDQ@mail.gmail.com>
	<50052276.2080906@redhat.com> <500527BA.9000001@redhat.com>
	<50052E7E.6020100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50052E7E.6020100@redhat.com>
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
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Il 17/07/2012 11:21, Asias He ha scritto:
>> It depends.  Like vhost-scsi, vhost-blk has the problem of a crippled
>> feature set: no support for block device formats, non-raw protocols,
>> etc.  This makes it different from vhost-net.
> 
> Data-plane qemu also has this cripppled feature set problem, no?

Yes, but that is just a proof of concept.  We can implement a separate
I/O thread within the QEMU block layer, and add fast paths that resemble
data-path QEMU, without limiting the feature set.

> Does user always choose to use block devices format like qcow2? What
> if they prefer raw image or raw block device?

If they do, the code should hit fast paths and be fast.  But it should
be automatic, without the need for extra knobs.  aio=thread vs.
aio=native is already one knob too much IMHO.

>> So it begs the question, is it going to be used in production, or just a
>> useful reference tool?
> 
> This should be decided by user, I can not speak for them. What is wrong
> with adding one option for user which they can decide?

Having to explain the user about the relative benefits; having to
support the API; having to handle transition from one more thing when
something better comes out.

Paolo
