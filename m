From: Mike Day <ncmike@ncultra.org>
Subject: Re: Announcing: Open OVF project source code availibility
Date: Tue, 12 Aug 2008 11:26:34 -0400
Message-ID: <20080812152634.GA8457__39437.6320219182$1218555137$gmane$org@silverwood.ncultra.org>
References: <20080812143432.GA8431@silverwood.ncultra.org>
	<20080812144656.GQ13067@redhat.com>
Reply-To: ncmike@ncultra.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080812144656.GQ13067@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, smoser@us.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On 12/08/08 15:46 +0100, Daniel P. Berrange wrote:
> 
> Why was the Eclipse Public License chosen ?  This license is not
> compatible with the GPL[1], so no GPL licensed app can make use of
> this code :-( For example it makes it impossible to use this code to
> assist in supporting OVF in virt-manager, virt-install or virt-image
> 
>   http://en.wikipedia.org/wiki/Eclipse_Public_License
> 
>   "The EPL 1.0 is not compatible with the GPL, and a work created by
>    combining a work licensed under the GPL with a work licensed under
>    the EPL cannot be lawfully distributed."
> 

As a file format, the output from open-ovf can be used by any
code of any license. That is, any code can consume an OVF file.

For runtime integration, we are planning on implementing an XML-RPC
interface into and out of the ovf library, which will allow any other
runtime code to interact with it. 

Mike


-- 
Mike Day
http://www.ncultra.org
AIM: ncmikeday |  Yahoo IM: ultra.runner
PGP key: http://www.ncultra.org/ncmike/pubkey.asc
