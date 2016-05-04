From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2] tools/virtio/ringtest: fix run-on-all.sh to work
	without /dev/cpu
Date: Wed, 4 May 2016 10:14:54 +0200
Message-ID: <20160504101454.2b62e974.cornelia.huck__46470.4855498441$1462349734$gmane$org@de.ibm.com>
References: <20160504084021.18cf98f0.cornelia.huck@de.ibm.com>
	<1462348793-6944-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1462348793-6944-1-git-send-email-rppt@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed,  4 May 2016 10:59:53 +0300
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> /dev/cpu is only available on x86 with certain modules (e.g. msr) enabled.
> Using lscpu to get processors count is more portable.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
> v2: use lspcu instead of /proc/cpuinfo as per Cornelia's suggestion
> 
>  tools/virtio/ringtest/run-on-all.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/virtio/ringtest/run-on-all.sh b/tools/virtio/ringtest/run-on-all.sh
> index 52b0f71..0177d50 100755
> --- a/tools/virtio/ringtest/run-on-all.sh
> +++ b/tools/virtio/ringtest/run-on-all.sh
> @@ -3,10 +3,10 @@
>  #use last CPU for host. Why not the first?
>  #many devices tend to use cpu0 by default so
>  #it tends to be busier
> -HOST_AFFINITY=$(cd /dev/cpu; ls|grep -v '[a-z]'|sort -n|tail -1)
> +HOST_AFFINITY=$(lscpu -p | tail -n 1 | cut -d',' -f1)

Shorter:

lscpu -p=cpu | tail -1

Should be good enough for a test tool :)

> 
>  #run command on all cpus
> -for cpu in $(cd /dev/cpu; ls|grep -v '[a-z]'|sort -n);
> +for cpu in $(seq 0 $HOST_AFFINITY)
>  do
>  	#Don't run guest and host on same CPU
>  	#It actually works ok if using signalling
