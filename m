From: Rik van Riel <riel@redhat.com>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Thu, 06 Nov 2008 11:57:17 -0500
Message-ID: <491321ED.5010103__3578.76073471761$1225990861$gmane$org@redhat.com>
References: <20081106153022.215696930@redhat.com>	
	<1225986593.7803.4688.camel@twins>
	<20081106160154.GA7461@redhat.com>	
	<1225988173.7803.4723.camel@twins>
	<20081106163957.GB7461@redhat.com>
	<1225990327.7803.4776.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1225990327.7803.4776.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: menage@google.com, Andrew Morton <akpm@linux-foundation.org>, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Hirokazu Takahashi <taka@valinux.co.jp>, Jeff Moyer <jmoyer@redhat.com>, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, Vivek Goyal <vgoyal@redhat.com>, Andrea Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Peter Zijlstra wrote:

> The only real issue I can see is with linear volumes, but those are
> stupid anyway - non of the gains but all the risks.

Linear volumes may well be the most common ones.

People start out with the filesystems at a certain size,
increasing onto a second (new) disk later, when more space
is required.

-- 
All rights reversed.
