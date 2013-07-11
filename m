From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Xen-devel] [PATCH] xen: remove unused Kconfig parameter
Date: Thu, 11 Jul 2013 23:13:57 +0200
Message-ID: <CAMuHMdX0aJnfVVF7Y0OvOMFO8zJTBrOjTG7fFisvFievZMpLcw@mail.gmail.com>
References: <1373264904-27053-1-git-send-email-michael.opdenacker@free-electrons.com>
	<20130708192854.GF4927@phenom.dumpdata.com>
	<20130708193457.GA6926@u109add4315675089e695.ant.amazon.com>
	<51DB2134.9040909@zytor.com> <20130708205834.GA481@pd.tnic>
	<1373326534.1438.10.camel@x61.thuisdomein>
	<f5d6bd67-7464-4932-a7ca-6026fe534fc7@email.android.com>
	<1373537338.9708.18.camel@x61.thuisdomein>
	<51DEF1F3.2020900@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51DEF1F3.2020900@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paul Bolle <pebolle@tiscali.nl>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>, the arch/x86 maintainers <x86@kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Matt Wilson <msw@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 11, 2013 at 7:57 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> The check grub2 currently performs in one of its configuration scripts
>> is (reformatted):
>>     if (grep -qx "CONFIG_XEN_DOM0=y" "${config}" 2> /dev/null ||
>>         grep -qx "CONFIG_XEN_PRIVILEGED_GUEST=y" "${config}" 2> /dev/null);
>>     then echo -n "$i " ;
>>     fi
>>
>
> If only grep supported looking for more than one string at a time.
> Maybe we could construct some kind of pattern expression syntax for it,
> perhaps based on the theory of regular languages?

grep -E "(pat1|pat2|pat3|...)"?

Or am I missing something?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
