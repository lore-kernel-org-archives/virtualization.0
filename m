From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 0/5] Add vhost-blk support
Date: Tue, 17 Jul 2012 12:11:15 +0100
Message-ID: <CAJSP0QW0tPV3WASGOBRE4hL=8zzSFQ6T=bHbEwMAzmHR9wnwJg__35402.1680345342$1342523487$gmane$org@mail.gmail.com>
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
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 17, 2012 at 10:21 AM, Asias He <asias@redhat.com> wrote:
> On 07/17/2012 04:52 PM, Paolo Bonzini wrote:
>>
>> Il 17/07/2012 10:29, Asias He ha scritto:
>>>
>>> So, vhost-blk at least saves ~6 syscalls for us in each request.
>>
>>
>> Are they really 6?  If I/O is coalesced by a factor of 3, for example
>> (i.e. each exit processes 3 requests), it's really 2 syscalls per request.
>
>
> Well. I am counting the number of syscalls in one notify and response
> process. Sure the IO can be coalesced.

Linux AIO also supports batching in io_submit() and io_getevents().
Depending on the request pattern in the vring when you process it, you
should be able to do better than 1 set of syscalls per host I/O
request.

Are you taking advantage of that at the moment in your userspace benchmark?

Stefan
