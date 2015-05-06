From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 0/6] x86: reduce paravirtualized spinlock overhead
Date: Wed, 06 May 2015 13:55:30 +0200
Message-ID: <554A0132.3070802@suse.com>
References: <1430391243-7112-1-git-send-email-jgross@suse.com>
	<55425ADA.4060105@goop.org> <554709BB.7090400@suse.com>
	<5548FC1A.7000806@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5548FC1A.7000806@goop.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com, chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, gleb@kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/05/2015 07:21 PM, Jeremy Fitzhardinge wrote:
> On 05/03/2015 10:55 PM, Juergen Gross wrote:
>> I did a small measurement of the pure locking functions on bare metal
>> without and with my patches.
>>
>> spin_lock() for the first time (lock and code not in cache) dropped from
>> about 600 to 500 cycles.
>>
>> spin_unlock() for first time dropped from 145 to 87 cycles.
>>
>> spin_lock() in a loop dropped from 48 to 45 cycles.
>>
>> spin_unlock() in the same loop dropped from 24 to 22 cycles.
>
> Did you isolate icache hot/cold from dcache hot/cold? It seems to me the
> main difference will be whether the branch predictor is warmed up rather
> than if the lock itself is in dcache, but its much more likely that the
> lock code is icache if the code is lock intensive, making the cold case
> moot. But that's pure speculation.
>
> Could you see any differences in workloads beyond microbenchmarks?
>
> Not that its my call at all, but I think we'd need to see some concrete
> improvements in real workloads before adding the complexity of more pvops.

I did another test on a larger machine:

25 kernel builds (time make -j 32) on a 32 core machine. Before each
build "make clean" was called, the first result after boot was omitted
to avoid disk cache warmup effects.

System time without my patches: 861.5664 +/- 3.3665 s
                with my patches: 852.2269 +/- 3.6629 s


Juergen
