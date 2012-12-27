From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 09/11] x86/xen/enlighten: Add init and crash kexec/kdump
	hooks
Date: Thu, 27 Dec 2012 10:53:41 -0800
Message-ID: <50DC9935.6000201@zytor.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-4-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-5-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-6-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-7-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-8-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-9-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-10-git-send-email-daniel.kiper@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1356574740-6806-10-git-send-email-daniel.kiper@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 12/26/2012 06:18 PM, Daniel Kiper wrote:
> Add init and crash kexec/kdump hooks.
>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> ---
>   arch/x86/xen/enlighten.c |   11 +++++++++++
>   1 files changed, 11 insertions(+), 0 deletions(-)

On the general issue of hooks:

Hooks need their pre- and postsemantics extremely ewell documented, let 
they end up being an impossible roadblock to development.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
