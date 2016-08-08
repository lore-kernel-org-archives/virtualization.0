From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 kernel 0/7] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Mon, 8 Aug 2016 09:15:58 -0700
Message-ID: <57A8B03E.4080709__15314.5512602807$1470672981$gmane$org@intel.com>
References: <1470638134-24149-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1470638134-24149-1-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>, linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 08/07/2016 11:35 PM, Liang Li wrote:
> Dave Hansen suggested a new scheme to encode the data structure,
> because of additional complexity, it's not implemented in v3.

FWIW, I don't think it takes any additional complexity here, at least in
the guest implementation side.  The thing I suggested would just mean
explicitly calling out that there was a single bitmap instead of
implying it in the ABI.

Do you think the scheme I suggested is the way to go?
