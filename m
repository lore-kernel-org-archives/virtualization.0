From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH v3 kernel 0/7] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Tue, 9 Aug 2016 02:52:41 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E0421A844__22203.7978856408$1470711177$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1470638134-24149-1-git-send-email-liang.z.li@intel.com>
	<57A8B03E.4080709@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <57A8B03E.4080709@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Re: [PATCH v3 kernel 0/7] Extend virtio-balloon for fast (de)inflating
> & fast live migration
> 
> On 08/07/2016 11:35 PM, Liang Li wrote:
> > Dave Hansen suggested a new scheme to encode the data structure,
> > because of additional complexity, it's not implemented in v3.
> 
> FWIW, I don't think it takes any additional complexity here, at least in the
> guest implementation side.  The thing I suggested would just mean explicitly
> calling out that there was a single bitmap instead of implying it in the ABI.
> 
> Do you think the scheme I suggested is the way to go?

Yes, I think so.  And I will do that in the later version. In this V3, I just want to solve the 
issue caused by a large page bitmap in v2.

Liang
