From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [patch 2/2] percpu enable flag for softlockup watchdog
Date: Tue, 27 Mar 2007 10:42:00 -0400
Message-ID: <46092D38.3020508@redhat.com>
References: <20070327053816.881735237@goop.org>
	<20070327054106.809292985@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070327054106.809292985@goop.org>
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
Cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, Linux Kernel <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



Jeremy Fitzhardinge wrote:
> +static DEFINE_PER_CPU(int, enabled);
>   =


Minor nit: let's call this softlockup_enabled.  Makes it easier for the =

reader ;)

P.
