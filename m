From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 03:03:11 -0700
Message-ID: <44EC27DF.2010204@vmware.com>
References: <1155202505.18420.5.camel@localhost.localdomain>
	<200608231141.37284.ak@suse.de> <44EC2450.3060706@vmware.com>
	<200608231150.17650.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200608231150.17650.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> And the functions they call?
>>     =

>
> Yes. But you only really need it for the actual callback, not the bulk
> of stop_machine_run() (which calls scheduler and lots of other stuff)
> The actual callback should be pretty limited already so it shouldn't
> be a big limitation.
>
> -Andi
>   =


Hmm.  Seems dangerous to rely on this, because functions could change =

from inline to out of line without people noticing that it affects this =

very corner case for kprobes + paravirt + stop_machine.  Is there a way =

to cascade the __kprobes declaration to all called functions, perhaps =

with a static checker, like sparse?

Zach
