From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH RFC] kvm: add PV MMIO EVENTFD
Date: Thu, 4 Apr 2013 19:33:34 +0300
Message-ID: <20130404163334.GE27672@redhat.com>
References: <20130404120825.GD17919@redhat.com>
	<959E147D-EB7B-4F4B-9F84-4F1BBA98DEF8@suse.de>
	<20130404123806.GG17919@redhat.com>
	<EF153515-9835-4FB9-B6BC-73D0BDC86492@suse.de>
	<20130404124501.GH17919@redhat.com>
	<1B68D701-103D-4B1A-8F5E-3916753699CB@suse.de>
	<20130404125649.GI17919@redhat.com>
	<8E65D34D-2DA7-4C2E-9C3E-BE3A7DBC3279@suse.de>
	<20130404133318.GI6467@redhat.com>
	<14B443D5-5785-487D-9EA3-0AD20141BC06@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <14B443D5-5785-487D-9EA3-0AD20141BC06@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Sasha Levin <sasha.levin@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Christoffer Dall <c.dall@virtualopensystems.com>, virtualization@lists.linux-foundation.org, Takuya Yoshikawa <yoshikawa_takuya_b1@lab.ntt.co.jp>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 04, 2013 at 05:36:40PM +0200, Alexander Graf wrote:
> > 
> > #define GOAL (1ull << 30)
> > 
> >        do {
> >                iterations *= 2;
> >                t1 = rdtsc();
> > 
> >                        for (i = 0; i < iterations; ++i)
> >                                func();
> >                t2 = rdtsc();
> >        } while ((t2 - t1) < GOAL);
> >        printf("%s %d\n", test->name, (int)((t2 - t1) / iterations));
> 
> So it's the number of cycles per run.
> 
> That means translated my numbers are:
> 
>   MMIO: 4307
>   PIO: 3658
>   HCALL: 1756
> 
> MMIO - PIO = 649
> 
> which aligns roughly with your PV MMIO callback.
> 
> My MMIO benchmark was to poke the LAPIC version register. That does go through instruction emulation, no?
> 
It should and PIO 'in' or string also goes through the emulator.

--
			Gleb.
