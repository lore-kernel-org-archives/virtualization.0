From: "Alexey Eremenko" <al4321@gmail.com>
Subject: Re: [PATCH] Move KVM, paravirt, lguest,
	VMI and Xen under arch-level Virtualization option
Date: Fri, 20 Jul 2007 06:31:55 +0200
Message-ID: <7fac565a0707192131t1af0982aq5a75fef2fe014762__41824.8024922379$1184906033$gmane$org@mail.gmail.com>
References: <1184905342.10380.263.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184905342.10380.263.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 7/20/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Any objections?
>
> Rusty.
> ===
> Having KVM appear in the middle of "drivers" is kinda strange, and
> having it alone under a menu called "virtualization" doubly so.
>

Hi Rusty !

Very good move, that I have thought about too... I believe that since
we're creating a Virtualization Menu, we should add
OS-level-virtualization there as well  (aka containerization) - the
following things: IPC virtualization (aka IPC namespaces), PID
virtualization, UTS virtualization. Those are 3 basic components that
went mainline into 2.6.19.

Article from OpenVZ:
http://www.linux.com/articles/59150?tid=136&tid=91

P.S. maybe rename those components from "IPC namespaces" to "IPC
virtualization" or even to "IPC containerization" it better reflect
it's internals?

-- 
-Alexey Eremenko "Technologov"
