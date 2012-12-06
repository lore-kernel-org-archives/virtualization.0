From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCHv2] x86info: dump kvm cpuid's
Date: Thu, 6 Dec 2012 09:48:30 -0500
Message-ID: <20121206144830.GA2450__13798.6383088448$1354805342$gmane$org@redhat.com>
References: <20120430143835.GA10190@redhat.com>
	<20120905173335.GA15141@redhat.com>
	<20121206114112.GA13963@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121206114112.GA13963@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xen-devel@lists.xensource.com, kvm@vger.kernel.org, pv-drivers@vmware.com, virtualization@lists.linux-foundation.org, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 06, 2012 at 01:41:12PM +0200, Michael S. Tsirkin wrote:
 > On Wed, Sep 05, 2012 at 08:33:35PM +0300, Michael S. Tsirkin wrote:
 > > On Mon, Apr 30, 2012 at 05:38:35PM +0300, Michael S. Tsirkin wrote:
 > > > The following makes 'x86info -r' dump hypervisor leaf cpu ids
 > > > (for kvm this is signature+features) when running in a vm.
 > > > 
 > > > On the guest we see the signature and the features:
 > > > eax in: 0x40000000, eax = 00000000 ebx = 4b4d564b ecx = 564b4d56 edx = 0000004d
 > > > eax in: 0x40000001, eax = 0100007b ebx = 00000000 ecx = 00000000 edx = 00000000
 > > > 
 > > > Hypervisor flag is checked to avoid output changes when not
 > > > running on a VM.
 > > > 
 > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
 > > > 
 > > > Changes from v1:
 > > > 	Make work on non KVM hypervisors (only KVM was tested).
 > > > 	Avi Kivity said kvm will in the future report
 > > > 	max HV leaf in eax. For now it reports eax = 0
 > > >         so add a work around for that.
 > > 
 > > Ping.
 > > Davej, any comments?
 > > Would be nice to have this in.
 > 
 > Is this the right address?
 > Davej do you maintain x86info?
 > Thanks,
 > MST

It's effectively abandonware at this point, largely due to my own
lack of time. hwloc and similar tools seem to have taken it's place.
If anyone is interested in taking over x86info, I'm happy to hand
over the reins to someone capable.

	Dave
