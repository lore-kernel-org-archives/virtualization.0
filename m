From: jiangyiwen <jiangyiwen@huawei.com>
Subject: Re: [PATCH v2 5/5] VSOCK: batch sending rx buffer to increase
	bandwidth
Date: Fri, 14 Dec 2018 09:05:15 +0800
Message-ID: <5C1301CB.9080703__20588.9653334909$1544749432$gmane$org@huawei.com>
References: <5C10D65F.7030407@huawei.com>
	<20181213151752.GK23318@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181213151752.GK23318@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2018/12/13 23:17, Stefan Hajnoczi wrote:
> On Wed, Dec 12, 2018 at 05:35:27PM +0800, jiangyiwen wrote:
>> Batch sending rx buffer can improve total bandwidth.
>>
>> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
>> ---
> 
> Please send patches with git-send-email --thread --no-chain-reply-to so
> that your patch series email thread looks like this:
> 
>   * [PATCH 00/NN] My feature
>   +-- [PATCH 01/NN] First patch
>   +-- [PATCH 02/NN] Second patch
>   .
>   .
>   .
>   +-- [PATCH NN/NN] Last patch
> 
> This way it's much easier to view the entire series.  At the moment you
> are sending each patch as an independent email and there is no
> relationship between the emails.
> 
> Thanks,
> Stefan
> 

Thanks Stefan, I have not send a series of patches before, and
I will use email thread form in the later version.

Thanks again,
Yiwen.
