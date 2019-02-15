From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net] vhost: correctly check the return value of
	translate_desc() in log_used()
Date: Fri, 15 Feb 2019 08:45:02 -0800
Message-ID: <20190215084502.23feed0e__21439.7011369996$1550249118$gmane$org@shemminger-XPS-13-9360>
References: <20190215075324.18891-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190215075324.18891-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 15 Feb 2019 15:53:24 +0800
Jason Wang <jasowang@redhat.com> wrote:

> When fail, translate_desc() returns negative value, otherwise the
> number of iovs. So we should fail when the return value is negative
> instead of a blindly check against zero.
> 
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Fixes: cc5e71075947 ("vhost: log dirty page correctly")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Looks good. It is best to put the Addresses-Coverity-Id tag on these kind
of bug fixes so that the automated tools see it.
