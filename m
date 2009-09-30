From: Shirley Ma <mashirle@us.ibm.com>
Subject: INFO: task journal:337 blocked for more than 120 seconds
Date: Wed, 30 Sep 2009 14:11:52 -0700
Message-ID: <1254345112.8837.9.camel__16047.4225682721$1254349948$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hello all,

Anybody found this problem before? I kept hitting this issue for 2.6.31
guest kernel even with a simple network test.

INFO: task kjournal:337 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_sec" disables this message.

kjournald	D 00000041	0	337	2 0x00000000

My test is totally being blocked.

Thanks
Shirley
