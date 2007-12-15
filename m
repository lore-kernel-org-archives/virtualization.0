From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 4/8] unify paravirt parts of system.h
Date: Sat, 15 Dec 2007 12:28:24 -0800
Message-ID: <476438E8.8090805__29718.5215553784$1197750851$gmane$org@zytor.com>
References: <11967843881946-git-send-email-gcosta@redhat.com>
	<11967843943958-git-send-email-gcosta@redhat.com>
	<11967843983411-git-send-email-gcosta@redhat.com>
	<11967844032081-git-send-email-gcosta@redhat.com>
	<11967844071346-git-send-email-gcosta@redhat.com>
	<4755A809.4050305@qumranet.com>
	<20071204193432.GI11764@bingen.suse.de>
	<20071205163017.GA4756@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20071205163017.GA4756@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ehabkost@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

Pavel Machek wrote:
> 
> It probably is safe to remove... but we currently support '2.8.95
> kernel loads/resumes 2.6.24 image'... which would break if 2.8 uses
> cr8.
> 
> So please keep it if it is not a big problem.
> 

Note that CR8 is an alias for the TPR in the APIC.

	-hpa
