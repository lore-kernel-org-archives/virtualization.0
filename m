From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 0/5] Add vhost-blk support
Date: Tue, 17 Jul 2012 13:03:39 +0100
Message-ID: <CAJSP0QXwGuUaD9piktOptJasdpci_fA90d=vV4m0SuORMvc2=Q@mail.gmail.com>
References: <1342107302-28116-1-git-send-email-asias@redhat.com>
	<CAJSP0QWgmXns89se+xdGgM6i1_hsfVWPQ8caHua9d-dDA4CTDQ@mail.gmail.com>
	<50052276.2080906@redhat.com> <500527BA.9000001@redhat.com>
	<50052E7E.6020100@redhat.com>
	<CAJSP0QW0tPV3WASGOBRE4hL=8zzSFQ6T=bHbEwMAzmHR9wnwJg@mail.gmail.com>
	<20120717112645.GA9363@redhat.com>
	<CAJSP0QXPkrVvgA+1fhhwsB5J8oApOObK8D3fk_Lm0Bt3T+Wfuw@mail.gmail.com>
	<20120717115450.GA9796@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120717115450.GA9796@redhat.com>
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
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 17, 2012 at 12:54 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> Knowing the answer to that is important before anyone can say whether
>> this approach is good or not.
>>
>> Stefan
>
> Why is it?

Because there might be a fix to kvmtool which closes the gap.  It
would be embarassing if vhost-blk was pushed just because no one
looked into what is actually going on.

And on the flipside, hard evidence of an overhead that cannot be
resolved could be good reason to do more vhost devices in the future.
Either way, it's useful to do this before going further.

Stefan
