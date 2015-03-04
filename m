From: Andrey Ryabinin <a.ryabinin@samsung.com>
Subject: Re: [Xen-devel] kasan_map_early_shadow() on Xen
Date: Wed, 04 Mar 2015 17:36:17 +0300
Message-ID: <54F71861.9050702__16919.379696674$1425500957$gmane$org@samsung.com>
References: <CAB=NE6Xs5fepzNtymzT4CueeJZ0KMPETpda114DpL4eMtDswtw@mail.gmail.com>
	<54F5B3DA.70203@samsung.com> <20150303141650.GA30332@l.oracle.com>
	<54F5D56C.6020803@samsung.com> <20150303160231.GA3518@l.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <20150303160231.GA3518@l.oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/03/2015 07:02 PM, Konrad Rzeszutek Wilk wrote:
> On Tue, Mar 03, 2015 at 06:38:20PM +0300, Andrey Ryabinin wrote:
>> On 03/03/2015 05:16 PM, Konrad Rzeszutek Wilk wrote:
>>> On Tue, Mar 03, 2015 at 04:15:06PM +0300, Andrey Ryabinin wrote:
>>>> On 03/03/2015 12:40 PM, Luis R. Rodriguez wrote:
>>>>> Andrey,
>>>>>
>>>>> I believe that on Xen we should disable kasan, would like confirmation
>>>>
>>>> I guess Xen guests won't work with kasan because Xen guests doesn't setup shadow
>>>> (kasan_map_early_shadow() is not called in xen guests).
>>>>
>>>> Disabling kasan for Xen in Kconfig is undesirable because that will disable kasan
>>>> for allmodconfig and allyesconfig builds, but I don't see other option for now.
>>>
>>> Was there an bug reported for this? It would be good to CC the maintainers
>>> of Xen on that sort of thing.
>>>
>>
>> There was no report for this. I just looked at Xen code because of this Luis's mail
>> and I don't see how it could work with kasan.
> 
> Ahh.
>> Fixing this might be not trivial. We need to setup shadow memory before any kasan instrumented
>> function will run.
>> This is like with -fstack-protector (you need to setup gdt before calling any stack protected function).
> 
> If it is like that - then just using what had to be implemented
> for the stack protection as a template ought to pave most of the
> work?
> 

Probably. I think I could make this work.
However, I won't be able to work on this until the end of the next week.
