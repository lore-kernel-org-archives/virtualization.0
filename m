From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [patch 3/4] Locally disable the softlockup watchdog rather than
 touching it
Date: Wed, 28 Mar 2007 10:00:15 -0400
Message-ID: <460A74EF.6000700@redhat.com>
References: <20070327214919.800272641@goop.org> <20070327215828.085422178@goop.org> <460A6EC0.4020701@redhat.com> <200703281550.04224.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751862AbXC1OBT@vger.kernel.org>
In-Reply-To: <200703281550.04224.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, John Hawkes <hawkes@sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <dada1@cosmosbay.com>
List-Id: virtualization@lists.linuxfoundation.org


>> touch_nmi_watchdog is attempting to tickle _all_ CPUs softlockup watchdogs.
>>     
>
> It is supposed to only touch the current CPU, just like it only touches
> the NMI watchdog on the current CPU.
>
>   

Andi,

(sorry for the cut-and-paste). 

touch_nmi_watchdogs sets EACH CPUs alert_counter to 0.

void touch_nmi_watchdog (void)
{
        if (nmi_watchdog > 0) {
                unsigned cpu;

                /*
                 * Just reset the alert counters, (other CPUs might be
                 * spinning on locks we hold):
                 */
                for_each_present_cpu (cpu)
                        alert_counter[cpu] = 0;
        }

        /*
         * Tickle the softlockup detector too:
         */
        touch_softlockup_watchdog();
}

The call to touch_softlockup_watchdog here is incorrect -- it is only 
touching the current CPU's softlockup.

P.
