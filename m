From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 9/10] provide __parainstructions section
Date: Fri, 18 Jan 2008 14:47:19 -0800
Message-ID: <47912C77.5090909__12017.6130593338$1200696630$gmane$org@goop.org>
References: <12006768251548-git-send-email-gcosta@redhat.com>
	<12006768362108-git-send-email-gcosta@redhat.com>
	<1200676842822-git-send-email-gcosta@redhat.com>
	<12006768473571-git-send-email-gcosta@redhat.com>
	<12006768521391-git-send-email-gcosta@redhat.com>
	<1200676857691-git-send-email-gcosta@redhat.com>
	<12006768631010-git-send-email-gcosta@redhat.com>
	<12006768683247-git-send-email-gcosta@redhat.com>
	<12006768732175-git-send-email-gcosta@redhat.com>
	<12006768793416-git-send-email-gcosta@redhat.com>
	<20080118204125.GA20904@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080118204125.GA20904@uranus.ravnborg.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Sam Ravnborg wrote:
> Are we going to see this for other archs than just x86?
> If so then please add this to include/asm-generic/vmlinux.lds.h
>   

In theory other architectures could use a similar mechanism, but for now 
its x86 specific.

    J
