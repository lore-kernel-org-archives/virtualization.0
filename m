From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] content: Reserve virtio device ID for pstore
Date: Wed, 20 Jul 2016 09:54:12 +0200
Message-ID: <20160720095412.075bc530.cornelia.huck__21375.668681185$1469001281$gmane$org@de.ibm.com>
References: <1468941217-12904-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1468941217-12904-1-git-send-email-namhyung@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Namhyung Kim <namhyung@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 20 Jul 2016 00:13:37 +0900
Namhyung Kim <namhyung@gmail.com> wrote:

> From: Namhyung Kim <namhyung@kernel.org>
> 
> This patch just reserve next available device ID for pstore device
> type.  The device specification for pstore will come later.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index d989d98..10bacc5 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2990,6 +2990,8 @@ Device ID  &  Virtio Device    \\
>  \hline
>  18         &   Input device \\
>  \hline
> +22         &   pstore device \\
> +\hline
>  \end{tabular}
> 
>  Some of the devices above are unspecified by this document,

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
