From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v33 0/4] Virtio-balloon: support free page reporting
Date: Fri, 15 Jun 2018 14:29:43 +0300
Message-ID: <20180615142610-mutt-send-email-mst__37380.3593953655$1529062259$gmane$org@kernel.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 15, 2018 at 12:43:09PM +0800, Wei Wang wrote:
>       - remove the cmd id related interface. Now host can just send a free
>         page hint command to the guest (via the host_cmd config register)
>         to start the reporting.

Here we go again. And what if reporting was already started previously?
I don't think it's a good idea to tweak the host/guest interface yet
again.

-- 
MST
