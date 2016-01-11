From: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH v4 0/3] checkpatch: handling of memory barriers
Date: Mon, 11 Jan 2016 22:06:14 +1100
Message-ID: <CAGRGNgXnxjmvjD8_vT17ZWwK0uCsGNmXq_KdVj9KoT6NRZQvPA__39340.1573681787$1452521974$gmane$org@mail.gmail.com>
References: <1452509968-19778-1-git-send-email-mst@redhat.com>
	<20160111130334-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160111130334-mutt-send-email-mst@redhat.com>
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Tony Lindgren <tony@atomide.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Andy Whitcroft <apw@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, "Mailing List,
	Arm" <linux-arm-kernel@lists.infradead.org>, Andrew Cooper <andrew.co>
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

On Mon, Jan 11, 2016 at 10:04 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jan 11, 2016 at 12:59:25PM +0200, Michael S. Tsirkin wrote:
>> As part of memory barrier cleanup, this patchset
>> extends checkpatch to make it easier to stop
>> incorrect memory barrier usage.
>>
>> This replaces the checkpatch patches in my series
>>       arch: barrier cleanup + barriers for virt
>> and will be included in the pull request including
>> the series.
>>
>> changes from v3:
>>       rename smp_barrier_stems to barrier_stems
>>       as suggested by Julian Calaby.
>
> In fact it was Joe Perches that suggested it.
> Sorry about the confusion.

I was about to point that out.

FWIW this entire series is:

Acked-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
