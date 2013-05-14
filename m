From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for May 14 (vhost_scsi)
Date: Tue, 14 May 2013 12:16:20 -0700
Message-ID: <51928D84.2040305__136.038152459328$1368562572$gmane$org@infradead.org>
References: <20130514141739.46eb9b42c95cb02947610379@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130514141739.46eb9b42c95cb02947610379@canb.auug.org.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Nicholas A. Bellinger" <nab@risingtidesystems.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/13/13 21:17, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20130513:
> 
> <crickets :-)>


on x86_64:

ERROR: "memcpy_fromiovec" [drivers/vhost/vhost_scsi.ko] undefined!


It needs to depend on NET since net/core/ provides that function.


-- 
~Randy
