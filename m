From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Jun 26 (xen/x86)
Date: Wed, 26 Jun 2013 11:48:58 -0700
Message-ID: <51CB379A.7010606__48101.5768171803$1372272588$gmane$org@infradead.org>
References: <20130626180653.57aee1721b4b5096ddc8f82d@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130626180653.57aee1721b4b5096ddc8f82d@canb.auug.org.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-next@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 06/26/13 01:06, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20130625:
> 

CONFIG_SMP is not set
CONFIG_X86_UP_APIC is not set

on i386:

drivers/built-in.o: In function `xen_callback_vector':
(.text+0x1dc3cb): undefined reference to `first_system_vector'
drivers/built-in.o: In function `xen_callback_vector':
(.text+0x1dc3f5): undefined reference to `first_system_vector'


-- 
~Randy
