From: "Dong, Eddie" <eddie.dong@intel.com>
Subject: RE: [kvm-devel] [PATCH/RFC 0/2] CPU hotplug virtio driver
Date: Tue, 22 Jan 2008 12:11:03 +0800
Message-ID: <10EA09EFD8728347A513008B6B0DA77A02AF0DD0__17580.9807763018$1200975249$gmane$org@pdsmsx411.ccr.corp.intel.com>
References: <11998740663306-git-send-email-gcosta@redhat.com><200801091227.12261.borntraeger@de.ibm.com><4784D882.1030104@redhat.com>
	<4784DC29.1020907@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <4784DC29.1020907@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, "Zhai, Edwin" <edwin.zhai@intel.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Glauber de Oliveira Costa wrote:
>> 
>> That said, if acpi is really the preference here, and this patches
>> have chance, no problem. But it will take me a little more time to
>> implement them ;-)
> 
> The power button support that was recently added at least proves that
> the host->guest notification path works, so that's one tooth that
> does not need pulling out.  The real trouble with acpi is
> understanding the spec which is very badly written.   
> 
> _AVI

Edwin implemented device hotplug support for Xen/Qemu, probably we
can reuse the effort. 

Edwin:
	Can u share the device hotplug patch with Glauber?
thx,eddie
