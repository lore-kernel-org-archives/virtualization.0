From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v6 3/3] mm: add vm event counters for balloon pages
	compaction
Date: Wed, 08 Aug 2012 21:40:13 -0400
Message-ID: <502314FD.7090701__14628.9069591605$1344476429$gmane$org@redhat.com>
References: <cover.1344463786.git.aquini@redhat.com>
	<768e09520a249fd78f706cd8ae53d511f9db0aaa.1344463786.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <768e09520a249fd78f706cd8ae53d511f9db0aaa.1344463786.git.aquini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rafael Aquini <aquini@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 08/08/2012 06:53 PM, Rafael Aquini wrote:
> This patch is only for testing report purposes and shall be dropped in case of
> the rest of this patchset getting accepted for merging.

I wonder if it would make sense to just keep these statistics, so
if a change breaks balloon migration in the future, we'll be able
to see it...

> Signed-off-by: Rafael Aquini<aquini@redhat.com>

Acked-by: Rik van Riel <riel@redhat.com>

-- 
All rights reversed
