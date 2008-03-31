From: Markus Armbruster <armbru@redhat.com>
Subject: Re: xen: Make hvc0 the preferred console in domU
Date: Mon, 31 Mar 2008 10:27:07 +0200
Message-ID: <87fxu79u3o.fsf__43372.8194832385$1206952293$gmane$org@pike.pond.sub.org>
References: <87zltm1p0s.fsf@pike.pond.sub.org> <47F08688.6050206@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47F08688.6050206@goop.org> (Jeremy Fitzhardinge's message of
	"Sun\, 30 Mar 2008 23\:36\:56 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Markus Armbruster wrote:
>> This makes the Xen console just work.  Before, you had to ask for it
>> on the kernel command line with console=hvc0
>>   
>
> I see that this has been causing issues when people expect the pvfb
> driver to be the console.  Should we make it a config option, which
> depends on !XENFB?
>
>    J

That's not quite right, I fear: you still lose if you have it compiled
into the guest, but switched off in your domain configuration.

I'm working on a better solution.
