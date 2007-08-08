From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: RE: Introducing paravirt_ops for x86_64
Date: Wed, 8 Aug 2007 07:53:43 -0700
Message-ID: <97D612E30E1F88419025B06CB4CF1BE10326E129__28572.8466966704$1186585608$gmane$org@scsmsx412.amr.corp.intel.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <11865467522495-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>, linux-kernel@vger.kernel.org
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> Hi folks,
> 
> After some time away from it, and a big rebase as a consequence, here
is
> the updated version of paravirt_ops for x86_64, heading to inclusion.
> 
> Your criticism is of course, very welcome.
> 
> Have fun

Do you assume that the kernel ougtht to use 2MB pages for its mappings
(e.g. initilal text/data,  direct mapping of physical memory) under your
paravirt_ops?  As far as I look at the patches, I don't find one. 

Jun
---
Intel Open Source Technology Center
