From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] linux-next: Tree for Jun 26 (xen/x86)
Date: Wed, 26 Jun 2013 17:25:09 -0400
Message-ID: <20130626212509.GB2810@phenom.dumpdata.com>
References: <20130626180653.57aee1721b4b5096ddc8f82d@canb.auug.org.au>
	<51CB379A.7010606@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51CB379A.7010606@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-next@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 26, 2013 at 11:48:58AM -0700, Randy Dunlap wrote:
> On 06/26/13 01:06, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20130625:
> > 
> 
> CONFIG_SMP is not set
> CONFIG_X86_UP_APIC is not set

That is new. Any thoughts of which patch might be the culprit?
What are the other config options? What XEN options are set?

> 
> on i386:
> 
> drivers/built-in.o: In function `xen_callback_vector':
> (.text+0x1dc3cb): undefined reference to `first_system_vector'
> drivers/built-in.o: In function `xen_callback_vector':
> (.text+0x1dc3f5): undefined reference to `first_system_vector'
> 
> 
> -- 
> ~Randy
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel
> 
