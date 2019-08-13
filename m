From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: DANGER WILL ROBINSON, DANGER
Date: Tue, 13 Aug 2019 14:02:58 +0200
Message-ID: <b6735416-602a-a2f5-5099-7e87c5162a6b@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-72-alazar@bitdefender.com>
	<20190809162444.GP5482@bombadil.infradead.org>
	<ae0d274c-96b1-3ac9-67f2-f31fd7bbdcee@redhat.com>
	<20190813112408.GC5307@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190813112408.GC5307@bombadil.infradead.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C <yu.c.zhang@intel.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Samuel_Laur=c3=a9n?= <samuel.lauren@iki.fi>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, virtualization@lists.linux-foundation.org, =?UTF-8?Q?Adalbert_Laz=c4=83r?= <alazar@bitdefender.com>, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zhang@kvack.org, =?UTF-8?Q?Mircea_C=c3=aerjaliu?= <mcirjaliu@bitdefender.com>, =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

On 13/08/19 13:24, Matthew Wilcox wrote:
>>>
>>> This is an awfully big patch to the memory management code, buried in
>>> the middle of a gigantic series which almost guarantees nobody would
>>> look at it.  I call shenanigans.
>> Are you calling shenanigans on the patch submitter (which is gratuitous)
>> or on the KVM maintainers/reviewers?
>
> On the patch submitter, of course.  How can I possibly be criticising you
> for something you didn't do?

No idea.  "Nobody would look at it" definitely includes me though.

In any case, water under the bridge.  The submitter did duly mark the
series as RFC, I don't see anything wrong in what he did apart from not
having testcases. :)

Paolo
