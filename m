From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: RFC: multiple address spaces for one process
Date: Sat, 30 Jun 2007 06:19:21 +0200
Message-ID: <4685D9C9.20504@de.ibm.com>
References: <87myynt1m6.wl%peter@chubb.wattle.id.au>
	<468517E1.4050803@goop.org>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <468517E1.4050803@goop.org>
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
Cc: linux-mm@kvack.org, Peter Chubb <peterc@gelato.unsw.edu.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> It might be interesting if the two cases could be unified in some way, 
> so that the VMMs could use a common usermode mechanism to achieve the 
> same end, which is what Carsten was proposing.  But its not obvious to 
> me how much common mechanism can be pulled out, since its a pretty 
> deeply architecture-specific operation.
The big difference here is that LinuxOnLinux does represent guest 
virtual addressing in these mm structs where all other kernel based 
VMMs do represent guest physical in the user address space. That 
somewhat disqualifies LinuxOnLinux to share the commonality.
Whether or not proposed patch makes sense for shaddow page tables is 
unknown to me, since we have nested paging on s390.
