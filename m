From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: Announcing: Open OVF project source code availibility
Date: Tue, 12 Aug 2008 15:46:56 +0100
Message-ID: <20080812144656.GQ13067__24961.3522472375$1218552701$gmane$org@redhat.com>
References: <20080812143432.GA8431@silverwood.ncultra.org>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080812143432.GA8431@silverwood.ncultra.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: smoser@us.ibm.com, xen-devel@lists.xensource.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 12, 2008 at 10:34:33AM -0400, Mike D. Day wrote:
> Announcing the open-ovf project and source code availibility.
> 
> Hi folks, we are announcing the availibility of source code for the
> open-ovf project. 

Why was the Eclipse Public License chosen ?  This license is not
compatible with the GPL[1], so no GPL licensed app can make use of
this code :-( For example it makes it impossible to use this code to
assist in supporting OVF in virt-manager, virt-install or virt-image

  http://en.wikipedia.org/wiki/Eclipse_Public_License

  "The EPL 1.0 is not compatible with the GPL, and a work created by
   combining a work licensed under the GPL with a work licensed under
   the EPL cannot be lawfully distributed."

Daniel
-- 
|: Red Hat, Engineering, London   -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org  -o-  http://virt-manager.org  -o-  http://ovirt.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-  F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|
