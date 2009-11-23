From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] vhost: Fix warnings and bad type handling
Date: Mon, 23 Nov 2009 12:31:44 +1030
Message-ID: <200911231231.45095.rusty__32107.627837877$1258941765$gmane$org@rustcorp.com.au>
References: <20091117154213.3683.94554.stgit@localhost.localdomain>
	<20091122102801.GA13644@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091122102801.GA13644@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 22 Nov 2009 08:58:01 pm Michael S. Tsirkin wrote:
> 
> From: Alan Cox <alan@linux.intel.com>
> Subject: [PATCH] vhost: fix warnings on 32 bit systems
> 
> Fix compiler warning about discarding top 32 bit
> of data on 32 bit systems, and document that
> dicarded bits must be 0.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> So I think the below slightly tweaked version of
> Alan's patch is a bit better. OK?

Thanks, applied.

Rusty.
