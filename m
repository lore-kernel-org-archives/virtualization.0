From: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH v3 3/3] checkpatch: add virt barriers
Date: Mon, 11 Jan 2016 21:40:18 +1100
Message-ID: <CAGRGNgU7=vNXZbgSwLs+bBueX1+rKACCRMi74hM+jP8MaX+-WA__15380.8012292304$1452521961$gmane$org@mail.gmail.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
	<1452454200-8844-4-git-send-email-mst@redhat.com>
	<CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
	<1452466336.7773.46.camel@perches.com>
	<20160111123423-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160111123423-mutt-send-email-mst@redhat.com>
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Tony Lindgren <tony@atomide.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Andrey Konovalov <andreyknvl@google.com>, adi-buildroot-devel@lists.sourceforge.net, Andy Whitcroft <apw@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, "Mailing List,
	Arm" <linux-arm-kernel@list>
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

On Mon, Jan 11, 2016 at 9:35 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sun, Jan 10, 2016 at 02:52:16PM -0800, Joe Perches wrote:
>> On Mon, 2016-01-11 at 09:13 +1100, Julian Calaby wrote:
>> > On Mon, Jan 11, 2016 at 6:31 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > > Add virt_ barriers to list of barriers to check for
>> > > presence of a comment.
>> []
>> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> []
>> > > @@ -5133,7 +5133,8 @@ sub process {
>> > >                 }x;
>> > >                 my $all_barriers = qr{
>> > >                         $barriers|
>> > > -                       smp_(?:$smp_barrier_stems)
>> > > +                       smp_(?:$smp_barrier_stems)|
>> > > +                       virt_(?:$smp_barrier_stems)
>> >
>> > Sorry I'm late to the party here, but would it make sense to write this as:
>> >
>> > (?:smp|virt)_(?:$smp_barrier_stems)
>>
>> Yes.  Perhaps the name might be better as barrier_stems.
>>
>> Also, ideally this would be longest match first or use \b
>> after the matches so that $all_barriers could work
>> successfully without a following \s*\(
>>
>> my $all_barriers = qr{
>>       (?:smp|virt)_(?:barrier_stems)|
>>       $barriers)
>> }x;
>>
>> or maybe add separate $smp_barriers and $virt_barriers
>>
>> <shrug>  it doesn't matter much in any case
>
> OK just to clarify - are you OK with merging the patch as is?
> Refactorings can come as patches on top if required.

I don't really care either way, I was just asking if it was possible.
If you don't see any value in that change, then don't make it.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
