From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: RE: [kvm-devel] [PATCH 1/3] KVM paravirt_ops infrastructure
Date: Wed, 30 May 2007 09:42:30 -0700
Message-ID: <97D612E30E1F88419025B06CB4CF1BE10259AAD7@scsmsx412.amr.corp.intel.com>
References: <465D8FA7.9050600@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <465D8FA7.9050600@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>, kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Regards,
> 
> Anthony Liguori

I think we should use the CPUID instruction (leaf 0x40000000) to detect
the hypervosor as we are doing in Xen. 

Jun
---
Intel Open Source Technology Center
