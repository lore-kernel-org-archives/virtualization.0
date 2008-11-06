From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Thu, 06 Nov 2008 18:11:27 +0100
Message-ID: <1225991487.7803.4801.camel__2239.43160749531$1225991985$gmane$org@twins>
References: <20081106153022.215696930@redhat.com>
	<1225986593.7803.4688.camel@twins> <20081106160154.GA7461@redhat.com>
	<1225988173.7803.4723.camel@twins> <20081106163957.GB7461@redhat.com>
	<1225990327.7803.4776.camel@twins>  <491321ED.5010103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <491321ED.5010103@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rik van Riel <riel@redhat.com>
Cc: menage@google.com, Andrew Morton <akpm@linux-foundation.org>, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Hirokazu Takahashi <taka@valinux.co.jp>, Jeff Moyer <jmoyer@redhat.com>, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, Vivek Goyal <vgoyal@redhat.com>, Andrea Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2008-11-06 at 11:57 -0500, Rik van Riel wrote:
> Peter Zijlstra wrote:
> 
> > The only real issue I can see is with linear volumes, but those are
> > stupid anyway - non of the gains but all the risks.
> 
> Linear volumes may well be the most common ones.
> 
> People start out with the filesystems at a certain size,
> increasing onto a second (new) disk later, when more space
> is required.

Are they aware of how risky linear volumes are? I would discourage
anyone from using them.
