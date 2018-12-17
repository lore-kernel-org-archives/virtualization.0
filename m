From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH]  Export mm_update_next_owner function for vhost-net
Date: Mon, 17 Dec 2018 03:32:54 -0800
Message-ID: <20181217113254.GA6971__37243.6270154596$1545046295$gmane$org@infradead.org>
References: <1544676445-14897-1-git-send-email-gchen.guomin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1544676445-14897-1-git-send-email-gchen.guomin@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gchen.guomin@gmail.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, virtualization@lists.linux-foundation.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, guominchen@tencent.com
List-Id: virtualization@lists.linuxfoundation.org

This seems like an issue all the unuse_mm users (at least those
outside of swapfile.c) have, so it should be solved in the core.

Bonus points for moving the set_fs magic into use_mm()..
