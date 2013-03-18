From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH V3 0/2] tcm_vhost hotplug/hotunplug support
Date: Mon, 18 Mar 2013 14:46:12 -0700
Message-ID: <1363643172.3156.62.camel@haakon2.linux-iscsi.org>
References: <1363056339-6061-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363056339-6061-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2013-03-12 at 10:45 +0800, Asias He wrote:
> Changes in v3:
> - Separate the bug fix to another thread
> 
> Changes in v2:
> - Remove code duplication in tcm_vhost_{hotplug,hotunplug}
> - Fix racing of vs_events_nr
> - Add flush fix patch to this series
> 
> 
> Asias He (2):
>   tcm_vhost: Introduce tcm_vhost_check_feature()
>   tcm_vhost: Add hotplug/hotunplug support
> 
>  drivers/vhost/tcm_vhost.c | 224 ++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/vhost/tcm_vhost.h |  10 +++
>  2 files changed, 229 insertions(+), 5 deletions(-)
> 

MST, are you OK with these two being applied to target-pending/for-next
now..?

--nab
