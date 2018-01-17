From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v22 2/3] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
Date: Wed, 17 Jan 2018 18:47:37 +0800
Message-ID: <5A5F29C9.4040706__10030.5199892775$1516185824$gmane$org@intel.com>
References: <1516165812-3995-1-git-send-email-wei.w.wang@intel.com>
	<1516165812-3995-3-git-send-email-wei.w.wang@intel.com>
	<1003745745.1007975.1516177271163.JavaMail.zimbra@redhat.com>
	<5A5F109B.7090200@intel.com>
	<1239524301.1023371.1516181271621.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1239524301.1023371.1516181271621.JavaMail.zimbra@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pankaj Gupta <pagupta@redhat.com>
Cc: yang zhang wz <yang.zhang.wz@gmail.com>, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan xu0 <quan.xu0@gmail.com>, kvm@vger.kernel.org, mst@redhat.com, nilal@redhat.com, liliang opensource <liliang.opensource@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/17/2018 05:27 PM, Pankaj Gupta wrote:
>> On 01/17/2018 04:21 PM, Pankaj Gupta wrote:
>>
> o.k  you have initialize "err = -ENOMEM;"
>
> Remove these four lines.
>   
>   -        kfree(names);
>   -        kfree(callbacks);
>   -        kfree(vqs);
>   -        return 0;
>
>   +        err = 0;              // if executed without any error
>

OK, thanks. "error = 0" is not needed actually.

Best,
Wei
