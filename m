From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH 5/8] scatterlist: introduce sg_unmark_end
Date: Thu, 7 Feb 2013 13:35:27 +0100
Message-ID: <20130207123527.GA15092__49433.6002077491$1360241799$gmane$org@kernel.dk>
References: <1360239752-2470-1-git-send-email-pbonzini@redhat.com>
	<1360239752-2470-6-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1360239752-2470-6-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 07 2013, Paolo Bonzini wrote:
> This is useful in places that recycle the same scatterlist multiple
> times, and do not want to incur the cost of sg_init_table every
> time in hot paths.

Looks fine to me.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
