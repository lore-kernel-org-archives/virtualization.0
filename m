From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/4] paravirt_ops-64 compile fixes
Date: Tue, 22 Jan 2008 09:55:41 -0800
Message-ID: <47962E1D.2090308__7695.38956597007$1201024781$gmane$org@goop.org>
References: <1200952133-31581-1-git-send-email-ehabkost@redhat.com>
	<20080122120207.GA30271@elte.hu> <20080122123450.GU7338@blackpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080122123450.GU7338@blackpad>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eduardo Pereira Habkost <ehabkost@redhat.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Eduardo Pereira Habkost wrote:
> If this is desirable for broader testing, we can make config PARAVIRT
> visible and selectable on menuconfig, even when there is no guest
> implementation being enabled. Should I do it?
>   

Yes please.

> Maybe should this force-paravirt mode be a kernel debugging option?
>   

No, just a plain CONFIG_PARAVIRT to turn it on and off independently of 
everything else.

    J
