From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v3] virtio_console: allocate inbufs in add_port() only if
 it is needed
Date: Fri, 22 Nov 2019 07:00:08 +0000
Message-ID: <20191122070009.5CE442068E@mail.kernel.org>
References: <20191114122548.24364-1-lvivier@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191114122548.24364-1-lvivier@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Sasha Levin <sashal@kernel.org>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: a7a69ec0d8e4 ("virtio_console: free buffers after reset").

The bot has tested the following trees: v5.3.11, v4.19.84, v4.14.154, v4.9.201, v4.4.201.

v5.3.11: Build OK!
v4.19.84: Build OK!
v4.14.154: Build OK!
v4.9.201: Failed to apply! Possible dependencies:
    5c60300d68da ("virtio_console: reset on out of memory")

v4.4.201: Failed to apply! Possible dependencies:
    5c60300d68da ("virtio_console: reset on out of memory")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks,
Sasha
