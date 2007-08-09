From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 25/25] [PATCH] add paravirtualization support for x86_64
Date: Wed, 08 Aug 2007 22:38:08 -0700
Message-ID: <46BAA840.2040403__34677.4672544145$1186638122$gmane$org@goop.org>
References: <11865467522495-git-send-email-gcosta@redhat.com>	
	<5d6222a80708080749t35c5c0ceo8b3b8f0cce50c666@mail.gmail.com>	
	<1186615137.17470.100.camel@localhost.localdomain>	
	<200708090224.16328.ak@suse.de>
	<1186620295.17752.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1186620295.17752.23.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Thu, 2007-08-09 at 02:24 +0200, Andi Kleen wrote:
>   
>> Not sure what's best. Ok using a normal export is easiest and not
>> that big an issue.
>>     
>
> Yeah, there's also been talk of breaking up paravirt_ops into multiple
> structs by area, which would lead naturally into finer-grained export
> control.

Yeah, I should dust that patch off again.

    J
