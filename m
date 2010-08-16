From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] paravirt: noreplace-paravirt is implemented for x86 and
 ia-64
Date: Mon, 16 Aug 2010 12:40:54 -0700
Message-ID: <4C699446.60309@goop.org>
References: <alpine.LNX.2.00.1008111832510.2702@pobox.suse.cz> <4C62D309.5010909@goop.org> <alpine.LNX.2.00.1008161503550.1019@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1008161503550.1019@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

 On 08/16/2010 06:04 AM, Jiri Kosina wrote:
> On Wed, 11 Aug 2010, Jeremy Fitzhardinge wrote:
>
>>  On 08/11/2010 09:34 AM, Jiri Kosina wrote:
>>> kernel-parameters.txt lists 'noreplace-paravirt' parameter as being
>>> limited to X86-32, which is incorrect -- it's actually supported by
>>> x86-32, x86-64 and ia-64.
>>>
>>> Signed-off-by: Jiri Kosina<jkosina@suse.cz>
>> Acked-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
> Thanks. As I haven't found the patch in linux-next as of today, I'll be 
> taking it through trivial queue.
Yes, thanks.  I didn't pick it up.

    J
