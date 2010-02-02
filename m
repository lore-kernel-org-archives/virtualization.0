From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2] virtio: Add ability to detach unused buffers from
	vrings
Date: Tue, 02 Feb 2010 15:59:11 -0800 (PST)
Message-ID: <20100202.155911.152356006.davem__20950.5489714958$1265155169$gmane$org@davemloft.net>
References: <201001292346.43675.rusty@rustcorp.com.au>
	<201001292349.05360.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201001292349.05360.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: netdev@vger.kernel.org, mashirle@us.ibm.com, mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Fri, 29 Jan 2010 23:49:05 +1030

> From: Shirley Ma <mashirle@us.ibm.com>
> 
> There's currently no way for a virtio driver to ask for unused
> buffers, so it has to keep a list itself to reclaim them at shutdown.
> This is redundant, since virtio_ring stores that information.  So
> add a new hook to do this.
> 
> Signed-off-by: Shirley Ma <xma@us.ibm.com>
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Applied.
